import React, { useEffect, useState, Fragment } from 'react';
import { index } from "../queries/Projects";
import { Link } from "react-router-dom";
import { isProjectManager } from "../helpers/user";
import TaskRow from "./Tasks/TaskRow";

const Projects = ({currentUser}) => {
    const [projects, setProjects] = useState([]);

    // Fetch current_user Projects
    useEffect(() => {
        (async () => {
            const projectsData = await index();
            if (!!projectsData) {
                setProjects(projectsData);
            }
        })()
    }, [])

    return (
        <div>
            { isProjectManager(currentUser) &&
                <Link to={'/projects/new'} className="btn btn-sm custom-button" role="button">Create Project</Link> }
            <h1>Projects</h1>
            <table className="table">
                <thead className={"table-dark"}>
                    <tr>
                        <th scope="col">Project Title</th>
                        <th scope="col">Project Description</th>
                        <th scope="col">Due Date</th>
                        <th scope="col">Project Manager</th>
                        <th scope="col">Employee Assigned To</th>
                        {isProjectManager(currentUser) && <th scope="col">Create Task</th>}
                    </tr>
                </thead>
            <tbody>
            {
                projects && projects.map((project) => {
                    return <Fragment key={project.id}>
                        <tr className={"table-secondary" }>
                            <td>{project.title}</td>
                            <td>{project.description}</td>
                            <td>{project.due_date}</td>
                            <td>{project.project_manager?.name}</td>
                            <td>{project.employee?.name}</td>
                            <td>
                                {
                                    isProjectManager(currentUser) &&
                                    <Link to={`/tasks/new?projectId=${project.id}`}
                                          className="btn btn-sm custom-button"
                                          role="button">
                                        Create Task
                                    </Link>
                                }
                            </td>
                        </tr>
                        {
                            project.tasks.length > 0 &&
                            <tr>
                                <td colSpan={isProjectManager(currentUser) ? 7 : 5}>
                                    <table className={'table mb-0'}>
                                        <thead className={"table-info"}>
                                            <tr>
                                                <th scope="col">Task Title</th>
                                                <th scope="col">Task Description</th>
                                                <th scope="col">Work Focus</th>
                                                <th scope="col">Due Date</th>
                                                <th scope="col">Status</th>
                                                <th scope="col">Project Manager</th>
                                                <th scope="col">Employee Assigned To</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                          {
                                              project.tasks.map((task) => {
                                                  if(!!task.parent_task_id) return;
                                                  return <TaskRow key={task.id}
                                                                  task={task}
                                                                  currentUser={currentUser}
                                                                  project={project}/>
                                              })
                                          }
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        }
                    </Fragment>
                })
            }
            </tbody>
            </table>
        </div>
    );
};

export default Projects;