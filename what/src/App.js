import React from "react";
import "./debug.css";
import Styles from "./App.module.css";

function App() {
  return (
    <>
      <header>
        <div className="bg-washed-red">
          <div className={"bg-washed-red " + Styles.hero}>
            <h1 className="f-headline">[NAME]</h1>
            <h3 className="f-subheadline">We do awesome things.</h3>
          </div>
        </div>
      </header>
      <footer className="footer pv4 ph3 ph5-m ph6-l mid-gray">
        <small className="f6 db tc">
          © 2019 <b className="ttu">Irving Place inc.</b>., All Rights Reserved
        </small>
      </footer>
    </>
  );
}

export default App;
