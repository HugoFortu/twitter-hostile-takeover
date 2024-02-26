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
        >
          <template v-slot:prepend>
            <v-icon color="indigo-lighten-1"></v-icon>
          </template>
          Home
        </v-btn>
      </v-col>
      <v-col
          class="text-center"
      >
        <v-btn
            prepend-icon="mdi-head"
            to="/tweets"
            flat
            min-width="10vw"
        >
          <template v-slot:prepend>
            <v-icon color="indigo-lighten-1"></v-icon>
          </template>
          Mes Tweets
        </v-btn>
      </v-col>
      <v-col
          class="text-center"
      >
        <v-btn
            prepend-icon="mdi-home"
            to="/login"
            flat
            min-width="10vw"
            class="mb-8"
        >
          <template v-slot:prepend>
            <v-icon color="indigo-lighten-1"></v-icon>
          </template>
          Home
        </v-btn>
      </v-col>
    </v-card>
  </v-container>
</template>
<script setup>

</script>