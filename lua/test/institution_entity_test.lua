-- Institution entity test

local json = require("dkjson")
local vs = require("utility.struct.struct")
local sdk = require("nordigen_sdk")
local helpers = require("core.helpers")
local runner = require("test.runner")

local _test_dir = debug.getinfo(1, "S").source:match("^@(.+/)")  or "./"

describe("InstitutionEntity", function()
  it("should create instance", function()
    local testsdk = sdk.test(nil, nil)
    local ent = testsdk:Institution(nil)
    assert.is_not_nil(ent)
  end)

  -- Feature #4: the entity stream(action, ...) method runs the op pipeline and
  -- returns an iterator over result items. With the streaming feature active it
  -- yields the feature's incremental output; otherwise it falls back to the
  -- materialised list so stream always yields.
  it("should stream", function()
    local seed = {
      entity = {
        ["institution"] = {
          s1 = { id = "s1" },
          s2 = { id = "s2" },
          s3 = { id = "s3" },
        },
      },
    }

    -- Fallback: streaming inactive -> yields the materialised list items.
    local base = sdk.test(seed, nil)
    local seen = {}
    for item in base:Institution(nil):stream("list", nil, nil) do
      table.insert(seen, item)
    end
    assert.are.equal(3, #seen)

    -- Inbound: streaming active -> yields each item from the feature.
    local config = require("config_shared")()
    if type(config.feature) == "table" and config.feature.streaming ~= nil then
      local streamsdk = sdk.test(seed, { feature = { streaming = { active = true } } })
      local got = {}
      for item in streamsdk:Institution(nil):stream("list", nil, nil) do
        if vs.islist(item) then
          for _, sub in ipairs(item) do
            table.insert(got, sub)
          end
        else
          table.insert(got, item)
        end
      end
      assert.are.equal(3, #got)
    end
  end)

  it("should run basic flow", function()
    local setup = institution_basic_setup(nil)
    -- Per-op sdk-test-control.json skip.
    local _live = setup.live or false
    for _, _op in ipairs({"list", "load"}) do
      local _should_skip, _reason = runner.is_control_skipped("entityOp", "institution." .. _op, _live and "live" or "unit")
      if _should_skip then
        pending(_reason or "skipped via sdk-test-control.json")
        return
      end
    end
    -- The basic flow consumes synthetic IDs from the fixture. In live mode
    -- without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup.synthetic_only then
      pending("live entity test uses synthetic IDs from fixture — set NORDIGEN_TEST_INSTITUTION_ENTID JSON to run live")
      return
    end
    local client = setup.client

    -- Bootstrap entity data from existing test data.
    local institution_ref01_data_raw = vs.items(helpers.to_map(
      vs.getpath(setup.data, "existing.institution")))
    local institution_ref01_data = nil
    if #institution_ref01_data_raw > 0 then
      institution_ref01_data = helpers.to_map(institution_ref01_data_raw[1][2])
    end

    -- LIST
    local institution_ref01_ent = client:Institution(nil)
    local institution_ref01_match = {}

    local institution_ref01_list_result, err = institution_ref01_ent:list(institution_ref01_match, nil)
    assert.is_nil(err)
    assert.is_table(institution_ref01_list_result)

    -- LOAD
    local institution_ref01_match_dt0 = {
      id = institution_ref01_data["id"],
    }
    local institution_ref01_data_dt0_loaded, err = institution_ref01_ent:load(institution_ref01_match_dt0, nil)
    assert.is_nil(err)
    local institution_ref01_data_dt0_load_result = helpers.to_map(type(institution_ref01_data_dt0_loaded) == 'table' and institution_ref01_data_dt0_loaded.data_get and institution_ref01_data_dt0_loaded:data_get() or institution_ref01_data_dt0_loaded)
    assert.is_not_nil(institution_ref01_data_dt0_load_result)
    assert.are.equal(institution_ref01_data_dt0_load_result["id"], institution_ref01_data["id"])

  end)
end)

function institution_basic_setup(extra)
  runner.load_env_local()

  local entity_data_file = _test_dir .. "../../.sdk/test/entity/institution/InstitutionTestData.json"
  local f = io.open(entity_data_file, "r")
  if f == nil then
    error("failed to read institution test data: " .. entity_data_file)
  end
  local entity_data_source = f:read("*a")
  f:close()

  local entity_data = json.decode(entity_data_source)

  local options = {}
  options["entity"] = entity_data["existing"]

  local client = sdk.test(options, extra)

  -- Generate idmap via transform.
  local idmap = vs.transform(
    { "institution01", "institution02", "institution03" },
    {
      ["`$PACK`"] = { "", {
        ["`$KEY`"] = "`$COPY`",
        ["`$VAL`"] = { "`$FORMAT`", "upper", "`$COPY`" },
      }},
    }
  )

  -- Detect ENTID env override before envOverride consumes it. When live
  -- mode is on without a real override, the basic test runs against synthetic
  -- IDs from the fixture and 4xx's. Surface this so the test can skip.
  local entid_env_raw = os.getenv("NORDIGEN_TEST_INSTITUTION_ENTID")
  local idmap_overridden = entid_env_raw ~= nil and entid_env_raw:match("^%s*{") ~= nil

  local env = runner.env_override({
    ["NORDIGEN_TEST_INSTITUTION_ENTID"] = idmap,
    ["NORDIGEN_TEST_LIVE"] = "FALSE",
    ["NORDIGEN_TEST_EXPLAIN"] = "FALSE",
    ["NORDIGEN_APIKEY"] = "NONE",
  })

  local idmap_resolved = helpers.to_map(
    env["NORDIGEN_TEST_INSTITUTION_ENTID"])
  if idmap_resolved == nil then
    idmap_resolved = helpers.to_map(idmap)
  end

  if env["NORDIGEN_TEST_LIVE"] == "TRUE" then
    local merged_opts = vs.merge({
      {
        apikey = env["NORDIGEN_APIKEY"],
      },
      extra or {},
    })
    client = sdk.new(helpers.to_map(merged_opts))
  end

  local live = env["NORDIGEN_TEST_LIVE"] == "TRUE"
  return {
    client = client,
    data = entity_data,
    idmap = idmap_resolved,
    env = env,
    explain = env["NORDIGEN_TEST_EXPLAIN"] == "TRUE",
    live = live,
    synthetic_only = live and not idmap_overridden,
    now = os.time() * 1000,
  }
end
