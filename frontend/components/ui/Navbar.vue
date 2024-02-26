<template>
      <v-navigation-drawer  v-model="sidebar" app >

      </v-navigation-drawer>

      <v-toolbar app >
        <v-toolbar-title>
          <router-link to="/" tag="span" class="app-title" style="cursor: pointer">
            {{ appTitle }}
          </router-link>
        </v-toolbar-title>
        <v-spacer></v-spacer>
        <v-toolbar-items class="bg-white">
          <v-btn
            v-if="route.path !== '/login'"
            flat
            to="/login"
            @click="logout"
          >
            {{ btnText }}
          </v-btn>
        </v-toolbar-items>
      </v-toolbar>
</template>

<script setup>
import { useAuthStore } from "~/store/auth";
const route = useRoute()
const authStore = useAuthStore();
const { user } = storeToRefs(authStore);
const config = useRuntimeConfig();
const appTitle = ref('TwXtter');
const sidebar = false;

const btnText = ref("Deconnexion");

const logout = () => {
  sessionStorage.setItem("isLogged", "false");
  sessionStorage.setItem("token", null);
}

</script>
