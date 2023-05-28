import React, { useEffect, useState } from 'react';
import { index } from "../queries/Employees";
import { Link } from "react-router-dom";
import { isProjectManager } from "../helpers/user";

const Employees = ({ currentUser }) => {
    const [employees, setEmployees] = useState([]);

    // Fetch Employees
    useEffect(() => {
        (async () => {
            const employeesData = await index();
            console.log('employeesData', typeof employeesData);
            if (!!employeesData) {
                setEmployees(employeesData);
            }
        })()
    }, [])

    return (
        <div>
            <h1>Employees</h1>
            {isProjectManager(currentUser) &&
                <Link to={'/employees/new'} className="btn btn-sm custom-button mb-2">Create Employee</Link>}
            <table className="table">
                <thead className={"table-dark"}>
                    <tr>
                        <th scope="col">Name</th>
                        <th scope="col">Email</th>
                        <th scope="col">Title</th>
                        <th scope="col">Work Focus</th>
                    </tr>
                </thead>
                <tbody>
                {
                    employees && employees.map((employee) => {
                        return <tr key={employee.id} className={"table-secondary" }>
                                <td>{employee.name}</td>
                                <td>{employee.email}</td>
                                <td>{employee.title}</td>
                                <td>{employee.work_focus}</td>
                            </tr>
                    })
                }
                </tbody>
            </table>
        </div>
    );
};

export default Employees;