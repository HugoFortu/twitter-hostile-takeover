<template>
  <v-container class="mt-8">
    <v-card class="left-menu" min-height="85vh" max-width="20vw">
      <v-col
          class="text-center"
      >
        <v-btn
            prepend-icon="mdi-home"
            to="/"
            flat
            min-width="10vw"
            class="mt-8"
            size="large"
        >
          <template v-slot:prepend>
            <v-icon size="x-large" color="#363636"></v-icon>
          </template>
          Accueil
        </v-btn>
      </v-col>
      <v-col
          class="text-center"
      >
        <v-btn
            prepend-icon="mdi-account"
            to="/tweets"
            flat
            min-width="10vw"
            size="large"
        >
          <template v-slot:prepend>
            <v-icon size="x-large" color="#363636"></v-icon>
          </template>
          Mes Tweets
        </v-btn>
      </v-col>
      <v-col
          class="text-center"
      >
        <v-btn
            prepend-icon="mdi-podium-gold"
            to="/leaderboard"
            flat
            min-width="10vw"
            class="mb-8"
            size="large"
        >
          <template v-slot:prepend>
            <v-icon size="x-large" color="#363636"></v-icon>
          </template>
          Classement
        </v-btn>
      </v-col>
    </v-card>
  </v-container>
</template>
<script setup>

</script>