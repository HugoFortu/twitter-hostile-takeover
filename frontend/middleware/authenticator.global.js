import { useAuthStore } from "~/store/auth";

export default defineNuxtRouteMiddleware(async (to, from) => {
    const authStore = useAuthStore();
    const config = useRuntimeConfig();
    const token = sessionStorage.getItem("token") || false;

    if (to.path === "/login") {
        return;
    }
    try {
        const response = await $fetch(`${config.public.baseApiUrl}/member-data`, {
            method: "GET",
            headers: {
                Authorization: `Bearer ${token}`,
            }
        })
        authStore.setUser(response.user)
    } catch(_) {
        return navigateTo('/login')
    }
})