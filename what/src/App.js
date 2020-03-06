import React from "react";
import Styles from "./App.module.css";
import Header from "./Header";
import Slogan from "./Slogan";
import First from "./First";
import "./global.css";
// import "./debug.css";

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

function App2() {
  return (
    <>
      <header>
        <div>
          <div
            className={
              "bg-washed-red pa3 flex flex-row justify-start items-center"
            }
          >
            <h1 className="f1">[NAME]</h1>
          </div>
        </div>
      </header>
      <div
        className={
          "ba b--near-white bw3 b--near-white flex flex-column items-center justify-center " +
          Styles.image1Parent
        }
      >
        <h3 className="f1">Let the party begin</h3>
        <Button href="#" text="Make us work" />
      </div>
      <div
        className={
          "ba b--near-white bw3 flex flex-column items-center justify-center " +
          Styles.image2Parent
        }
      >
        <h3 className="f1">Take your kids along</h3>
        <Button href="#" text="Just go god damn it." />
      </div>

      <footer className="footer pv4 ph3 ph5-m ph6-l mid-gray">
        <small className="f6 db tc">
          © 2019 <b className="ttu">Irving Place inc.</b>., All Rights Reserved
        </small>
      </footer>
    </>
  );
}

const App = () => (
  <>
    <Header /> <First />
  </>
);
export default App;
