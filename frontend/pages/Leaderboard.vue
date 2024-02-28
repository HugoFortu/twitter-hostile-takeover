<template>
  <v-container>
    <div class="border-custom my-8 ">
      <v-card class="mx-auto text-center">
        <v-card-title class="text-h4 pt-8">Classement des utilisateurs</v-card-title>
        <v-card-text>Lequel d'entre vous a t-il le plus de like sur ses tweets ?</v-card-text>
        <v-card
            class="mx-auto my-8 text-center"
            flat
            max-width="30rem"
            v-for="(user, index) in users" :key="index"
        >
          <v-card-item>
            <v-card-title>
              @{{ user.pseudo }}
            </v-card-title>
          </v-card-item>
          <v-card-text>
            total des points : {{ user.total }}
          </v-card-text>
        </v-card>
      </v-card>
    </div>
  </v-container>
</template>

<script setup>
import { ref, onMounted } from "vue";
const users = ref([]);
const config = useRuntimeConfig();
const index = () => {
  $fetch(`${config.public.baseApiUrl}/leaderboard`, {
    credentials: "include",
  }).then((response) => {
    users.value = response
  })
}

onMounted(() => {
  index();
});

</script>