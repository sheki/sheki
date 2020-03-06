import React from "react";
import Styles from "./First.module.css";
import suitcase from "./suitcase-pink.jpg";

const First = () => (
  <div className={Styles.first + " mw-100 mt3"}>
    <img className="mh3" width="50%" src={suitcase} alt="Suitcase" />
    <div className={"mh3 h-100" + Styles.text}>
      <span className="f3">
        Holidays are about the experience, don’t the travel planning get in the
        way.
      </span>
    </div>
  </div>
);

export default First;
