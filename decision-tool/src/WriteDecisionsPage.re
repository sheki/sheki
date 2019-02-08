module OptionEditor = {
  let component = ReasonReact.statelessComponent("OptionEditor");
  let make = (~value: string, ~onChange, ~heading, _children) => {
    ...component,
    render: _self =>
      <div className="c-card">
        <div className="c-card__item c-card__item--divider">
          {ReasonReact.string(heading)}
        </div>
        <div className="c-card__item  ">
          <p className="c-paragraph">
            <input
              style={
                ReactDOMRe.Style.make(
                  ~border="0",
                  ~outline="0",
                  ~background="transparent",
                  ~borderBottom="1px solid black",
                  (),
                )
              }
              type_="text"
              value
              onChange={
                event =>
                  ignore(onChange(ReactEvent.Form.target(event)##value))
              }
              size=50
            />
          </p>
        </div>
      </div>,
  };
};

let component = ReasonReact.statelessComponent("WriteDecisions");

let make = (~decisionA: string, ~decisionB: string, ~onChange, _children) => {
  ...component,
  render: _self =>
    <div>
      <h2> {ReasonReact.string("Write your options")} </h2>
      <div
        style={
          ReactDOMRe.Style.make(
            ~display="flex",
            ~flexDirection="row",
            ~marginTop="10px",
            (),
          )
        }>
        <div className="u-pillar-box-super">
          <OptionEditor
            value=decisionA
            heading="Option A"
            onChange={optionA => onChange(optionA, decisionB)}
          />
        </div>
        <div className="u-pillar-box-super">
          <OptionEditor
            value=decisionB
            heading="Option B"
            onChange={optionB => onChange(decisionA, optionB)}
          />
        </div>
      </div>
    </div>,
};
