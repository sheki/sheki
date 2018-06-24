package stack

import "fmt"

type Stack struct {
	store []string
	opLog []operation
}

func (s *Stack) Push(input string) {
	s.store = append(s.store, input)
	s.recordOp(pushAction, input)
}

func (s *Stack) recordOp(action action, input string) {
	if len(s.opLog) == 0 {
		return
	}

	s.opLog = append(s.opLog, operation{action: action, value: input})
}

func (s *Stack) Pop() string {
	if len(s.store) == 0 {
		return ""
	}
	retVal := s.store[len(s.store)-1]
	s.store = s.store[:len(s.store)-1]
	s.recordOp(popAction, retVal)
	return retVal
}

func (s *Stack) Begin() {
	s.opLog = append(s.opLog, operation{action: beginAction, value: ""})
}

func (s *Stack) lastoperationIndex() int {
	lastoperationIndex := 0
	for j := len(s.opLog) - 1; j >= 0; j-- {
		if s.opLog[j].action == beginAction {
			lastoperationIndex = j
			break
		}
	}
	return lastoperationIndex
}

func (s *Stack) Commit() {
	if len(s.opLog) == 0 {
		return
	}
	index := s.lastoperationIndex()
	s.opLog = s.opLog[:index]
}

func (s *Stack) Rollback() {
	if len(s.opLog) == 0 {
		return
	}
	index := s.lastoperationIndex()
	for i := len(s.opLog) - 1; i > index; i-- {
		op := s.opLog[i]
		s.applyReverse(op)
	}
	s.opLog = s.opLog[:index]
}

func (s *Stack) applyReverse(op operation) {
	switch op.action {
	case pushAction:
		s.Pop()
	case popAction:
		s.Push(op.value)
	default:
		panic(fmt.Sprintf("unexepected operation type %d", op.action))
	}
}

type action int

const (
	pushAction action = iota
	popAction
	beginAction
)

type operation struct {
	action action
	value  string
}

func (t operation) String() string {
	return fmt.Sprintf("Action: %q, value %s", t.action, t.value)
}
