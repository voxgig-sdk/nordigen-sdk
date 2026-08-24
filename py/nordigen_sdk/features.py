# Nordigen SDK feature factory

from nordigen_sdk.feature.base_feature import NordigenBaseFeature
from nordigen_sdk.feature.test_feature import NordigenTestFeature


_FEATURES = {
    "base": lambda: NordigenBaseFeature(),
    "test": lambda: NordigenTestFeature(),
}


def _make_feature(name):
    factory = _FEATURES.get(name)
    if factory is not None:
        return factory()
    return _FEATURES["base"]()


# True when this SDK was generated with the named feature class - the
# constructor's tolerance for extend-carried features reads this (an
# active name with no generated class must not become a BaseFeature
# stray when an extend instance carries it).
def _has_feature(name):
    return name in _FEATURES
