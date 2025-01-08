--!strict

export type Scheme = {
	apply: (targetObject: GuiObject) -> (),
	run: (functionName: string, optionalArguments: any?) -> (),
	_scheme: {[string]: any},
	_runningTasks: {[number]: thread},
	_boundListeners: {[string]: EventListener}
}

export type EventListener = {
	eventName: string,
	handler: (...any) -> (),
	targetObject: GuiObject,
	disconnect: () -> (),
}

return nil
