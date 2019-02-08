let component = ReasonReact.statelessComponent("Point");
let make = _children => {
  ...component,
  render: _self =>
    <div>
      <h1 className="c-heading u-super"> {ReasonReact.string("Welcome")} </h1>
      <p>
        {
          ReasonReact.string(
            "Cognitive behavior therapy (CBT) is a tool that aims to improve mental health. If you procastrinate on decisions, give this tool a shot",
          )
        }
      </p>
    </div>,
};
