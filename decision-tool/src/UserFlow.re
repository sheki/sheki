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
  disadvantagesA: list(string),
  advantagesB: list(string),
  disadvantagesB: list(string),
};

type argumentType =
  | Disadvantage
  | Advantage;

type optionType =
  | OptionA
  | OptionB;

type action =
  | Next
  | SetDecisions(string, string)
  | SetPoints(argumentType, optionType, list(string));

let component = ReasonReact.reducerComponent("UserFlow");

let make = _children => {
  ...component,
  initialState: () => {
    currentStep: Intro,
    decisionA: "",
    decisionB: "",
    advantagesA: [],
    disadvantagesA: [],
    advantagesB: [],
    disadvantagesB: [],
  },
  reducer: (action, state) =>
    switch (action, state.currentStep) {
    | (Next, Intro) =>
      ReasonReact.Update({...state, currentStep: WriteDecisions})
    | (Next, WriteDecisions) =>
      ReasonReact.Update({...state, currentStep: AdvA})
    | (Next, AdvA) => ReasonReact.Update({...state, currentStep: DisadvA})
    | (Next, DisadvA) => ReasonReact.Update({...state, currentStep: AdvB})
    | (Next, AdvB) => ReasonReact.Update({...state, currentStep: DisadvB})
    | (SetDecisions(a, b), _) =>
      ReasonReact.Update({...state, decisionA: a, decisionB: b})
    | (SetPoints(Advantage, OptionA, points), _) =>
      ReasonReact.Update({...state, advantagesA: points})
    | (SetPoints(Disadvantage, OptionA, points), _) =>
      ReasonReact.Update({...state, disadvantagesA: points})
    | (SetPoints(Advantage, OptionB, points), _) =>
      ReasonReact.Update({...state, advantagesB: points})
    | (SetPoints(Disadvantage, OptionB, points), _) =>
      ReasonReact.Update({...state, disadvantagesB: points})
    | _ => ReasonReact.NoUpdate
    },
  render: self =>
    <div
      style={
        ReactDOMRe.Style.make(
          ~display="flex",
          ~flexDirection="column",
          ~alignItems="center",
          ~marginTop="10px",
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
        | AdvA =>
          <PointsEditor
            heading={"Advantages: " ++ self.state.decisionA}
            points={self.state.advantagesA}
            onChange=(
              points => self.send(SetPoints(Advantage, OptionA, points))
            )
          />
        | DisadvA =>
          <PointsEditor
            heading={"Disadvantages: " ++ self.state.decisionA}
            points={self.state.disadvantagesA}
            onChange=(
              points => self.send(SetPoints(Disadvantage, OptionA, points))
            )
          />
        | AdvB =>
          <PointsEditor
            heading={"Advantages: " ++ self.state.decisionB}
            points={self.state.advantagesB}
            onChange=(
              points => self.send(SetPoints(Advantage, OptionB, points))
            )
          />
        | DisadvB =>
          <PointsEditor
            heading={"Disadvantages: " ++ self.state.decisionB}
            points={self.state.disadvantagesB}
            onChange=(
              points => self.send(SetPoints(Disadvantage, OptionB, points))
            )
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
