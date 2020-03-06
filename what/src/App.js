import React from "react";
import Styles from "./App.module.css";

function Button(props) {
  return (
    <a
      className="f3 link br3 dim ph3 pv2 mb2 dib white bg-dark-blue"
      href={props.href}
    >
      {props.text}
    </a>
  );
}

function App() {
  return (
    <>
      <header>
        <div className="bg-washed-red">
          <div className={"bg-washed-red " + Styles.hero}>
            <h1 className="f-headline">[NAME]</h1>
            <h3 className="f1">You live the experience. We do the work.</h3>
            <Button href="#" text="Take a trip" />
          </div>
        </div>
      </header>
      <div
        className={
          "ba bw3 flex flex-column items-center justify-center " +
          Styles.image1Parent
        }
      >
        <h3 className="f1">Let the party begin</h3>
        <Button href="#" text="Make us work" />
      </div>
      <footer className="footer pv4 ph3 ph5-m ph6-l mid-gray">
        <small className="f6 db tc">
          © 2019 <b className="ttu">Irving Place inc.</b>., All Rights Reserved
        </small>
      </footer>
    </>
  );
}

export default App;
