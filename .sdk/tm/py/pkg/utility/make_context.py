# Nordigen SDK utility: make_context

from projectname_sdk.core.context import NordigenContext


def make_context_util(ctxmap, basectx):
    return NordigenContext(ctxmap, basectx)
