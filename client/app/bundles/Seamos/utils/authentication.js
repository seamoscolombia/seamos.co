export const isAuthenticated = () => {
    const session = localStorage.getItem('session');
    const user = localStorage.getItem('user');
    if (user && session) {
        return true;
    }
    return false;
};
