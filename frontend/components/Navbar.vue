<template>
      <v-navigation-drawer v-model="sidebar" app >
        <v-list>
          <v-list-tile
            v-for="item in menuItems"
            :key="item.title"
            :to="item.path">
            <v-list-tile-action>
              <v-icon>{{ item.icon }}</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>{{ item.title }}</v-list-tile-content>
          </v-list-tile>
        </v-list>
      </v-navigation-drawer>

      <v-toolbar app >
        <span class="hidden-sm-and-up">
          <v-toolbar-side-icon @click="sidebar = !sidebar">
          </v-toolbar-side-icon>
        </span>
        <v-toolbar-title>
          <router-link to="/" tag="span" style="cursor: pointer">
            {{ appTitle }}
          </router-link>
        </v-toolbar-title>
        <v-spacer></v-spacer>
        <v-toolbar-items class="hidden-xs-only">
          <v-btn
            flat
            v-for="item in menuItems"
            :key="item.title"
            :to="item.path">
            {{ item.title }}
          </v-btn>
        </v-toolbar-items>
      </v-toolbar>
</template>

<script setup>
const appTitle = ref('TwXtter');
const sidebar = false;
const menuItems = ref([
      { title: 'Home', path: '/' },
      { title: 'Connexion', path: '/login' }
    ]);
</script>
