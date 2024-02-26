<template>
  <NuxtLayout>
    <v-app class="body">
      <v-row>
        <v-col>
          <Navbar />
        </v-col>
      </v-row>
      <v-row class="mt-8">
        <v-col
          class="hidden-sm-and-down"
          cols="3"
          md="3"
        >
          <LeftMenu v-if="route.path !== '/login'" />
        </v-col>
        <v-col
            cols="12"
            md="6">
          <NuxtPage />
        </v-col>
        <v-col class="hidden-sm-and-down">
        </v-col>
      </v-row>
    </v-app>
  </NuxtLayout>
</template>

<script setup>
import Navbar from "~/components/ui/Navbar.vue";
import LeftMenu from "~/components/ui/LeftMenu.vue";
const route = useRoute()
</script>
