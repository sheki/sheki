import React from "react";
import Styles from "./First.module.css";
import suitcase from "./suitcase-pink.jpg";
import family from "./family-kids.jpg";

const First = () => (
  <>
    <div className={Styles.first + " mw-100 mt3"}>
      <img className="mh3" width="50%" src={suitcase} alt="Suitcase" />
      <div className={"mh3 h-100 " + Styles.text}>
        <span className="f3 tc pa4">
          Holidays are about the experience, don’t let the travel planning get
          in the way.
        </span>
      </div>
    </div>
    <div className={Styles.first + " mw-100 mt3"}>
      <div className={" mh3 h-100 " + Styles.text}>
        <div className="f3 mb2 pa4 tc">
          We plan your trips, help you pick flights, choose hotels and if you
          want will build you an iternary. Think of us as your travel assistant.
        </div>
        <a class="f4 link dim br3 ph3 pv2 mr4 dib white bg-dark-blue" href="#0">
          Take a trip
        </a>
      </div>
      <img className="mh3" width="50%" src={family} alt="family" />
    </div>
  </>
);

export default First;
