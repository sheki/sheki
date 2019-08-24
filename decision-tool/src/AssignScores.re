module ScoreRange = {
  let component = ReasonReact.statelessComponent("ScoreRange");
  let make = (~leftValue, ~onChange, _children) => {
    ...component,
    render: _self =>
      <div
        style={
          ReactDOMRe.Style.make(~display="flex", ~flexDirection="row", ())
        }>
        <h1 className="c-heading u-super u-pillar-box-large">
          {ReasonReact.string(string_of_int(leftValue))}
        </h1>
        <input
          type_="range"
          value={string_of_int(leftValue)}
          className="c-range c-range--info"
          onChange={
            event => {
              let score =
                int_of_string(ReactEvent.Form.target(event)##value);
              onChange(score);
            }
          }
        />
        <h1 className="c-heading u-super u-pillar-box-large">
          {ReasonReact.string(string_of_int(100 - leftValue))}
        </h1>
      </div>,
  };
};

module PointsDisplay = {
  let component = ReasonReact.statelessComponent("PointsDisplay");
  let make = (~points, ~heading, _children) => {
    ...component,
    render: _self =>
      <div className="u-pillar-box-medium">
        <h1 className="c-heading u-medium">
          {ReasonReact.string(heading)}
        </h1>
        <ul className="c-list">
          {
            ReasonReact.array(
              Array.of_list(
                List.map(
                  point =>
                    <li className="c-list__item">
                      {ReasonReact.string(point)}
                    </li>,
                  points,
                ),
              ),
            )
          }
        </ul>
      </div>,
  };
};

let component = ReasonReact.statelessComponent("AssignScores");
let make =
    (
      ~leftPoints,
      ~leftHeading,
      ~rightHeading,
      ~rightPoints,
      ~onChange,
      ~leftValue,
      _children,
    ) => {
  ...component,
  render: _self =>
    <div className="c-card">
      <header className="c-card__header">
        <h2 className="c-heading"> {ReasonReact.string("Compare")} </h2>
      </header>
      <div className="c-card__body">
        <div className="o-grid">
          <div className="o-grid__cell">
            <PointsDisplay points=leftPoints heading=leftHeading />
          </div>
          <div className="o-grid__cell">
            <ScoreRange leftValue onChange />
          </div>
          <div className="o-grid__cell">
            <PointsDisplay points=rightPoints heading=rightHeading />
          </div>
        </div>
      </div>
    </div>,
};
