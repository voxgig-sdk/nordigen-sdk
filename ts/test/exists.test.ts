
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { NordigenSDK } from '..'


describe('exists', async () => {

  test('test-mode', async () => {
    const testsdk = await NordigenSDK.test()
    equal(null !== testsdk, true)
  })

})
