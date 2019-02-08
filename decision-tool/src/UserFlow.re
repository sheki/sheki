type step =
  | Intro
  | WriteDecisions
  | AdvA
  | DisadvA
  | AdvB
  | DisadvB
  | CompareAllA
  | CompareAllB
  | CompareAdv
  | CompareDisdv
  | FinalScore;

type state = {
  currentStep: step,
  decisionA: string,
  decisionB: string,
  advantagesA: list(string),
};

type action =
  | Next
  | SetDecisions(string, string);

let component = ReasonReact.reducerComponent("UserFlow");

let make = _children => {
  ...component,
  initialState: () => {
    currentStep: Intro,
    decisionA: "",
    decisionB: "",
    advantagesA: [],
  },
  reducer: (action, state) =>
    switch (action, state.currentStep) {
    | (Next, Intro) =>
      ReasonReact.Update({...state, currentStep: WriteDecisions})
    | (Next, WriteDecisions) =>
      ReasonReact.Update({...state, currentStep: AdvA})
    | (SetDecisions(a, b), _) =>
      ReasonReact.Update({...state, decisionA: a, decisionB: b})
    | _ => ReasonReact.NoUpdate
    },
  render: self =>
    <div
      style={
        ReactDOMRe.Style.make(
          ~display="flex",
          ~flexDirection="column",
          ~alignItems="center",
          (),
        )
      }>
      {
        switch (self.state.currentStep) {
        | Intro => <IntroPage />
        | WriteDecisions =>
          <WriteDecisionsPage
            decisionA={self.state.decisionA}
            decisionB={self.state.decisionB}
            onChange=((a, b) => self.send(SetDecisions(a, b)))
          />
        | _ => <div> {ReasonReact.string("Not yet implemented")} </div>
        }
      }
      <button
        style={ReactDOMRe.Style.make(~marginTop="10px", ())}
        type_="button"
        onClick={_e => self.send(Next)}
        className="c-button c-button--success">
        {ReasonReact.string("Next")}
      </button>
    </div>,
};
