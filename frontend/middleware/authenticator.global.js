
export default defineNuxtRouteMiddleware(async (to, from) => {

    const token = sessionStorage.getItem("token");

    $fetch(`http://0.0.0.0:8080/member-data`, {
      method: "GET",
      headers: {
        Authorization: `Bearer ${token}`,
      }
    }).then((response) => {
      console.log(response)
    })
    // if (to.params.id === '1') {
    //     return abortNavigation()
    // }
    //
    // if (to.path !== '/') {
    //     return navigateTo('/')
    // }
})