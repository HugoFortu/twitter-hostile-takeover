<template>
  <v-toolbar>
    <v-toolbar-title>
      <router-link to="/" tag="span" class="app-title" style="cursor: pointer">
        {{ appTitle }}
      </router-link>
    </v-toolbar-title>
    <v-spacer></v-spacer>
    <v-toolbar-items class="bg-white">
      <v-menu v-if="route.path !== '/login'" class="hidden-md-and-up">
        <template v-slot:activator="{ props }">
          <v-btn
              class="hidden-md-and-up"
              prepend-icon="mdi-menu"
              size="lg"
              color="primary"
              v-bind="props"
          >
            <template v-slot:prepend>
              <v-icon size="x-large" color="#363636"></v-icon>
            </template>
          </v-btn>
        </template>
        <v-list>
          <v-list-item to="/">
            <v-list-item-title>Accueil</v-list-item-title>
          </v-list-item>
          <v-list-item to="/tweets">
            <v-list-item-title>Mes tweets</v-list-item-title>
          </v-list-item>
          <v-list-item
              to="/leaderboard"
          >
            <v-list-item-title>Classement</v-list-item-title>
          </v-list-item>
          <v-list-item
              to="/login"
              @click="logout"
          >
            <v-list-item-title>{{ btnText }}</v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
      <v-btn
        class="hidden-sm-and-down"
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
const btnText = ref("Deconnexion");

const logout = () => {
  sessionStorage.setItem("isLogged", "false");
  sessionStorage.setItem("token", null);
}

</script>
