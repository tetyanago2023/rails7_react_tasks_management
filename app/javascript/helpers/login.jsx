import axios from "axios";

export const loginStatus = async () => {
    const result = await axios.get('http://localhost:3000/logged_in',
        {withCredentials: true})
        .then(response => {
            return { isLoggedIn: response.data.logged_in, user: response.data.user }
        })
        .catch(error => console.log('api errors:', error))

    return result
}
