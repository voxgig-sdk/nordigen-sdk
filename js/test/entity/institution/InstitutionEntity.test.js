
const envlocal = __dirname + '/../../../.env.local'
require('dotenv').config({ quiet: true, path: [envlocal] })

const Path = require('node:path')
const Fs = require('node:fs')

const { test, describe } = require('node:test')
const assert = require('node:assert')


const { NordigenSDK, BaseFeature, stdutil, config } = require('../../..')

const {
  envOverride,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
} = require('../../utility')


describe('InstitutionEntity', async () => {

  test('instance', async () => {
    const testsdk = NordigenSDK.test()
    const ent = testsdk.Institution()
    assert(null != ent)
  })


  test('basic', async () => {

    const setup = basicSetup()
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select

    let institution_ref01_data = Object.values(setup.data.existing.institution)[0]

    // LIST
    const institution_ref01_ent = client.Institution()
    const institution_ref01_match = {}

    const institution_ref01_list = (await institution_ref01_ent.list(institution_ref01_match)).map((e) => e.data())


    // LOAD
    const institution_ref01_match_dt0 = {}
    institution_ref01_match_dt0.id = institution_ref01_data.id
    const institution_ref01_data_dt0 = (await institution_ref01_ent.load(institution_ref01_match_dt0)).data()
    assert(institution_ref01_data_dt0.id === institution_ref01_data.id)


  })
})



function basicSetup(extra) {
  // TODO: fix test def options
  const options = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname,
      '../../../../.sdk/test/entity/institution/InstitutionTestData.json')

  // TODO: file ready util needed?
  const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8')

  // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
  const entityData = JSON.parse(entityDataSource)

  options.entity = entityData.existing

  let client = NordigenSDK.test(options, extra)
  const struct = client.utility().struct
  const merge = struct.merge
  const transform = struct.transform

  let idmap = transform(
    ['institution01','institution02','institution03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'NORDIGEN_TEST_INSTITUTION_ENTID': idmap,
    'NORDIGEN_TEST_LIVE': 'FALSE',
    'NORDIGEN_TEST_EXPLAIN': 'FALSE',
    'NORDIGEN_APIKEY': 'NONE',
  })

  idmap = env['NORDIGEN_TEST_INSTITUTION_ENTID']

  if ('TRUE' === env.NORDIGEN_TEST_LIVE) {
    client = new NordigenSDK(merge([
      {
        apikey: env.NORDIGEN_APIKEY,
      },
      extra
    ]))
  }

  const setup = {
    idmap,
    env,
    options,
    client,
    struct,
    data: entityData,
    explain: 'TRUE' === env.NORDIGEN_TEST_EXPLAIN,
    now: Date.now(),
  }

  return setup
}
  
