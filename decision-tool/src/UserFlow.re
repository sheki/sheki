type step =
  | Intro
  | WriteDecisions
  | AdvA
  | DisadvA
  | AdvB
  | DisadvB
  | CompareA
  | CompareB
  | CompareAdv
  | CompareDisadv
  | FinalScore;

type state = {
  currentStep: step,
  decisionA: string,
  decisionB: string,
  advantagesA: list(string),
  disadvantagesA: list(string),
  advantagesB: list(string),
  disadvantagesB: list(string),
  scoreCompareA: int,
  scoreCompareB: int,
  scoreCompareAdvAoverB: int,
  scoreCompareDisadvAoverB: int,
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
  | SetPoints(argumentType, optionType, list(string))
  | SetScore(optionType, argumentType, optionType, argumentType, int);

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
    scoreCompareA: 50,
    scoreCompareB: 50,
    scoreCompareAdvAoverB: 50,
    scoreCompareDisadvAoverB: 50,
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
    | (Next, DisadvB) =>
      ReasonReact.Update({...state, currentStep: CompareA})
    | (Next, CompareA) =>
      ReasonReact.Update({...state, currentStep: CompareB})
    | (Next, CompareB) =>
      ReasonReact.Update({...state, currentStep: CompareAdv})
    | (Next, CompareAdv) =>
      ReasonReact.Update({...state, currentStep: CompareDisadv})
    | (Next, CompareDisadv) =>
      ReasonReact.Update({...state, currentStep: FinalScore})
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
    | (SetScore(OptionA, Advantage, OptionA, Disadvantage, score), _) =>
      ReasonReact.Update({...state, scoreCompareA: score})
    | (SetScore(OptionB, Advantage, OptionB, Disadvantage, score), _) =>
      ReasonReact.Update({...state, scoreCompareB: score})
    | (SetScore(OptionA, Advantage, OptionB, Advantage, score), _) =>
      ReasonReact.Update({...state, scoreCompareAdvAoverB: score})
    | (SetScore(OptionA, Disadvantage, OptionB, Disadvantage, score), _) =>
      ReasonReact.Update({...state, scoreCompareDisadvAoverB: score})
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
        | CompareA =>
          <AssignScores
            leftPoints={self.state.advantagesA}
            leftHeading={"Advantages of " ++ self.state.decisionA}
            rightPoints={self.state.disadvantagesA}
            rightHeading={"Disadvantages of " ++ self.state.decisionA}
            leftValue={self.state.scoreCompareA}
            onChange=(
              s =>
                self.send(
                  SetScore(OptionA, Advantage, OptionA, Disadvantage, s),
                )
            )
          />
        | CompareB =>
          <AssignScores
            leftPoints={self.state.advantagesB}
            leftHeading={"Advantages of " ++ self.state.decisionB}
            rightPoints={self.state.disadvantagesB}
            rightHeading={"Disadvantages of " ++ self.state.decisionB}
            leftValue={self.state.scoreCompareB}
            onChange=(
              s =>
                self.send(
                  SetScore(OptionB, Advantage, OptionB, Disadvantage, s),
                )
            )
          />
        | CompareAdv =>
          <AssignScores
            leftPoints={self.state.advantagesA}
            leftHeading={"Advantages of " ++ self.state.decisionA}
            rightPoints={self.state.advantagesB}
            rightHeading={"Advantages of " ++ self.state.decisionB}
            leftValue={self.state.scoreCompareAdvAoverB}
            onChange=(
              s =>
                self.send(
                  SetScore(OptionA, Advantage, OptionB, Advantage, s),
                )
            )
          />
        | CompareDisadv =>
          <AssignScores
            leftPoints={self.state.disadvantagesA}
            leftHeading={"Disadvantages of " ++ self.state.decisionA}
            rightPoints={self.state.disadvantagesB}
            rightHeading={"Disadvantages of " ++ self.state.decisionB}
            leftValue={self.state.scoreCompareDisadvAoverB}
            onChange=(
              s =>
                self.send(
                  SetScore(OptionA, Disadvantage, OptionB, Disadvantage, s),
                )
            )
          />
        | FinalScore =>
          <FinalScore
            optionA={self.state.decisionA}
            optionB={self.state.decisionB}
            allDisadv={self.state.scoreCompareDisadvAoverB}
            allAdv={self.state.scoreCompareAdvAoverB}
            advA={self.state.scoreCompareA}
            advB={self.state.scoreCompareB}
          />
        }
      }
      {
        switch (self.state.currentStep) {
        | FinalScore => <div />
        | _ =>
          <button
            type_="button"
            onClick=(_e => self.send(Next))
            className="c-button c-button--success u-letter-box-medium">
            {ReasonReact.string("Next")}
          </button>
        }
      }
    </div>,
};
