package core

var UtilityRegistrar func(u *Utility)

var NewBaseFeatureFunc func() Feature

var NewTestFeatureFunc func() Feature

var NewInstitutionEntityFunc func(client *NordigenSDK, entopts map[string]any) NordigenEntity

