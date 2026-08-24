# Nordigen SDK exists test

import pytest
from nordigen_sdk import NordigenSDK


class TestExists:

    def test_should_create_test_sdk(self):
        testsdk = NordigenSDK.test(None, None)
        assert testsdk is not None
