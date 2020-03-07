import React from "react";
import Styles from "./Header.module.css";

function Header() {
  return (
    <>
      <div className={Styles.header}>
        <div className="f1 ml4">This Way To</div>
        <a
          class="f4 link dim br3 ph3 pv2 mr4 dib white bg-dark-blue"
          href="/form.html"
        >
          Take a trip
        </a>
      </div>
      <div style={{ marginTop: 120 }} />
    </>
  );
}

export default Header;
