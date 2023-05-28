import axios from "axios";

export const index = async () => {
    return await axios.get('http://localhost:3000/api/projects')
        .then(response => {
            return response.data.projects
        })
        .catch(error => console.log('api errors:', error))
}
export const create = async (project, callback, errorCallback) => {
     await axios.post('http://localhost:3000/api/projects', { project })
        .then(response => {
            if (response.data.project) {
                callback()
            }
        })
        .catch(error => {
            console.log('api errors:', error)
            errorCallback(error.response.data.errors.join(' '))
        })
}
