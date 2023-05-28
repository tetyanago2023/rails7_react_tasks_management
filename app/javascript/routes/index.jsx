import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Home from "../components/Home";
import Login from "../components/Login";
import Projects from "../components/Projects";
import NewTask from "../components/Tasks/NewTask";
import { default as NewProject } from "../components/Projects/New";
import ProtectedRoute from "../components/ProtectedRoute";
import Employees from "../components/Employees";
import NewEmployee from "../components/Employees/NewEmployee";

export default (
    <Router>
        <Routes>
            <Route path="/" exact element={<Home />} />
            <Route path='/login' element={<Login />}/>

            <Route path='/projects/new' element={
                <ProtectedRoute>
                    <NewProject />
                </ProtectedRoute>
            }/>
            <Route path='/projects' element={
                <ProtectedRoute>
                    <Projects />
                </ProtectedRoute>
            }/>
            <Route path='/employees/new' element={
                <ProtectedRoute>
                    <NewEmployee/>
                </ProtectedRoute>
            }/>
            <Route path='/employees' element={
                <ProtectedRoute>
                    <Employees/>
                </ProtectedRoute>
            }/>
            <Route path='/tasks/new' element={
                <ProtectedRoute>
                    <NewTask />
                </ProtectedRoute>
            }/>
        </Routes>
    </Router>
);