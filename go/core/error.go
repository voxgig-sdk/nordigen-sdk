package core

type NordigenError struct {
	IsNordigenError bool
	Sdk              string
	Code             string
	Msg              string
	Ctx              *Context
	Result           any
	Spec             any
}

func NewNordigenError(code string, msg string, ctx *Context) *NordigenError {
	return &NordigenError{
		IsNordigenError: true,
		Sdk:              "Nordigen",
		Code:             code,
		Msg:              msg,
		Ctx:              ctx,
	}
}

func (e *NordigenError) Error() string {
	return e.Msg
}
