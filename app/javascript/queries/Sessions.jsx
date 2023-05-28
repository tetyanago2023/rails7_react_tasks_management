import axios from "axios";

export const login = async (user, callback, errorCallback) => {
    await axios.post('http://localhost:3000/login', { user }, { withCredentials: true })
        .then(response => {
            if (response.data.logged_in) {
                callback()
            } else {
                errorCallback(response.data.errors)
            }
        })
        .catch(error => console.log('api errors:', error))
}

export const logout = async (callback = () => {}, errorCallback = () => {}) => {
    await axios.post('http://localhost:3000/logout')
        .then(response => {
            if (response.data.logged_out) {
                callback()
            } else {
                errorCallback(response.data.errors)
            }
        })
        .catch(error => console.log('api errors:', error))
}
