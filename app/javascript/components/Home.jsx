import React from "react";
import { Link } from "react-router-dom";

export default () => (
    <div className="vw-100 vh-100 primary-color d-flex align-items-center justify-content-center">
        <div className="jumbotron jumbotron-fluid bg-transparent">
            <div className="container secondary-color">
                <Link to='/projects' className="btn btn-lg custom-button" role="button">Projects</Link>
                <Link to='/employees' className="btn btn-lg custom-button" role="button">Employees</Link>
            </div>
        </div>
    </div>
);