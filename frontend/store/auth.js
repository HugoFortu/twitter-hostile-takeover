import { defineStore } from "pinia";

export const useAuthStore = defineStore({
    id: "auth-store",
    state: () => ({
        user: {},

    }),
    actions: {
         setUser(user) {
            this.user = user;
        }
    }
})