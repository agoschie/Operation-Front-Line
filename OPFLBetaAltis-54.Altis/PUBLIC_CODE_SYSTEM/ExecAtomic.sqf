private "_handle";

_handle = _this execFSM "PUBLIC_CODE_SYSTEM\CriticalProcessor.fsm";
waitUntil {completedFSM _handle};