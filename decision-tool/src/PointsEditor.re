module PointComponent = {
  let pointComponent = ReasonReact.statelessComponent("Point");
  let make = (~pointText, _children) => {
    ...pointComponent,
    render: _self => <div> {ReasonReact.string(pointText)} </div>,
  };
};

module PointList = {
  let component = ReasonReact.statelessComponent("PointList");

  let make = (~points, _children) => {
    ...component,
    render: _self =>
      <ul className="c-list">
        {
          ReasonReact.array(
            Array.of_list(
              List.map(
                point =>
                  <li className="c-list__item">
                    <PointComponent pointText=point />
                  </li>,
                points,
              ),
            ),
          )
        }
      </ul>,
  };
};

module PointEditRow = {
  type state = {
    text: string,
    inputRef: ref(option(Dom.element)),
  };

  type action =
    | Done
    | Edit(string);

  let setInputRef = (theRef, {ReasonReact.state}) =>
    state.inputRef := Js.Nullable.toOption(theRef);

  let component = ReasonReact.reducerComponent("PointsEditRow");

  let make = (~onComplete, _children) => {
    ...component,
    initialState: () => {text: "", inputRef: ref(None)},
    reducer: (action, state) =>
      switch (action) {
      | Done => ReasonReact.SideEffects((_self => onComplete(state.text)))
      | Edit(value) => ReasonReact.Update({...state, text: value})
      },
    didMount: self =>
      switch (self.state.inputRef^) {
      | Some(htmlField) =>
        let node = ReactDOMRe.domElementToObj(htmlField);
        ignore(node##focus());
      | _ => ()
      },
    render: self =>
      <div className="o-grid">
        <div className="o-grid__cell o-grid__cell--width-80">
          <input
            ref={self.handle(setInputRef)}
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
            value={self.state.text}
            onChange={
              event => self.send(Edit(ReactEvent.Form.target(event)##value))
            }
            size=80
          />
        </div>
        <div className="o-grid__cell">
          <button
            disabled={String.trim(self.state.text) == ""}
            type_="button"
            onClick={_e => self.send(Done)}
            className="c-button u-small">
            {ReasonReact.string("Done")}
          </button>
        </div>
      </div>,
  };
};

type state = {addingNew: bool};

type action =
  | Add
  | Done(list(string));
let component = ReasonReact.reducerComponent("PointsEditor");

let make = (~heading, ~onChange, ~points, _children) => {
  ...component,
  initialState: () => {addingNew: false},
  reducer: (action, _state) =>
    switch (action) {
    | Add => ReasonReact.Update({addingNew: true})
    | Done(points) =>
      ReasonReact.UpdateWithSideEffects(
        {addingNew: false},
        (self => onChange(points)),
      )
    },
  render: self =>
    <div className="c-card">
      <div className="c-card__item c-card__item--divider">
        {ReasonReact.string(heading)}
      </div>
      <div className="c-card__body">
        <PointList points />
        {
          self.state.addingNew ?
            <PointEditRow
              onComplete={text => self.send(Done(points @ [text]))}
            /> :
            <div
              style={
                ReactDOMRe.Style.make(
                  ~marginTop="5px",
                  ~display="flex",
                  ~flexDirection="row",
                  ~justifyContent="flexStart",
                  (),
                )
              }>
              <button
                style={ReactDOMRe.Style.make(~marginRight="10px", ())}
                type_="button"
                onClick={_e => self.send(Add)}
                className="c-button">
                {ReasonReact.string("Add")}
              </button>
            </div>
        }
      </div>
    </div>,
};
