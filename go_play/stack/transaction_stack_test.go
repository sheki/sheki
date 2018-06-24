package stack

import "testing"

func TestPushPop(t *testing.T) {
	s := Stack{}
	s.Push("a")
	if s.Pop() != "a" {
		t.Fatal("expected `a`")
	}

	if s.Pop() != "" {
		t.Fatal("expected empty value")
	}
}

func TestEmptyStackPop(t *testing.T) {
	s := Stack{}
	if s.Pop() != "" {
		t.Fatal("expected empty string")
	}

}

func TestBasicCommit(t *testing.T) {
	s := Stack{}
	s.Push("a")
	s.Begin()
	if s.Pop() != "a" {
		t.Fatal("cannot pop within transaction")
	}
	s.Push("b")
	if s.Pop() != "b" {
		t.Fatal("cannot pop within transaction after pushing")
	}
	s.Commit()
	if s.Pop() != "" {
		t.Fatal("expect empty stack")
	}
}

func TestBasicRollback(t *testing.T) {
	s := Stack{}
	s.Push("a")
	s.Begin()
	s.Push("b")
	s.Push("b")
	s.Push("b")
	if s.Pop() != "b" {
		t.Fatal("cannot pop within transaction after pushing")
	}
	s.Rollback()
	val := s.Pop()
	if val != "a" {
		t.Fatalf("rollback altered stack expected `a` got `%s`", val)
	}
}

func TestNestedCommit(t *testing.T) {
	s := Stack{}
	s.Push("a")
	s.Begin()
	s.Push("b")
	s.Push("c")
	s.Push("d")
	s.Begin()
	if s.Pop() != "d" {
		t.Fatal("cannot pop within 2nd level transaction")
	}
	s.Push("e")
	s.Commit()
	if s.Pop() != "e" {
		t.Fatal("pop failure after inner commit")
	}
	s.Commit()
	val := s.Pop()
	if val != "c" {
		t.Fatalf("rollback altered stack expected `a` got `%s`", val)
	}
}

func TestNestedRollback(t *testing.T) {
	s := Stack{}
	s.Push("a")
	s.Begin()
	s.Push("b")
	s.Push("c")
	s.Push("d")
	s.Begin()
	if s.Pop() != "d" {
		t.Fatal("cannot pop within 2nd level transaction")
	}
	s.Push("e")
	s.Rollback()
	if s.Pop() != "d" {
		t.Fatal("failed to rollback innter transaction")
	}
}
