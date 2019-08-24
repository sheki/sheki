module FinalScorePiece = {
  let component = ReasonReact.statelessComponent("FinalScorePiece");
  let make = (~optionStr, ~score, _children) => {
    ...component,
    render: _self =>
      <h1 className="c-heading u-large">
        {
          ReasonReact.string(
            "Score for " ++ optionStr ++ " " ++ string_of_int(score),
          )
        }
      </h1>,
  };
};

let calculateScoreA = (advA, allAdv, allDisadv) =>
  advA + allAdv - (100 - advA + allDisadv);

let calculateScoreB = (advB, allAdv, allDisadv) =>
  advB + (100 - allAdv) - (100 - advB + (100 - allDisadv));

let component = ReasonReact.statelessComponent("FinalScore");
let make = (~advA, ~advB, ~allAdv, ~allDisadv, ~optionA, ~optionB, _children) => {
  ...component,
  render: _self =>
    <div
      style={
        ReactDOMRe.Style.make(
          ~width="100%",
          ~flexDirection="column",
          ~alignItems="center",
          (),
        )
      }>
      <div
        className="u-pillar-box-super"
        style={
          ReactDOMRe.Style.make(
            ~display="flex",
            ~flexDirection="row",
            ~justifyContent="center",
            (),
          )
        }>
        <FinalScorePiece
          optionStr=optionA
          score={calculateScoreA(advA, allAdv, allDisadv)}
        />
        <div className="u-pillar-box-super" />
        <FinalScorePiece
          optionStr=optionB
          score={calculateScoreB(advB, allAdv, allDisadv)}
        />
      </div>
      <div>
        {
          let style =
            ReactDOMRe.Style.make(
              ~display="flex",
              ~flexDirection="row",
              ~justifyContent="center",
              (),
            );
          let scoreA = calculateScoreA(advA, allAdv, allDisadv);
          let scoreB = calculateScoreB(advB, allAdv, allDisadv);
          if (scoreA > scoreB) {
            <span className="u-text--highlight" style>
              {ReasonReact.string("Pick " ++ optionA ++ " you must.")}
            </span>;
          } else {
            <span className="u-text--highlight" style>
              {ReasonReact.string("Pick " ++ optionB ++ " you must.")}
            </span>;
          };
        }
      </div>
    </div>,
};
