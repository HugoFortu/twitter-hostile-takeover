<template>
  <v-form v-model="valid">
      <v-container style="margin-top: 100px;">
        <v-col
          cols="12"
          md="12"
        >
          <v-text-field
            v-model="email"
            label="Email"
            hide-details
            required
          ></v-text-field>
        </v-col>

        <v-col
          cols="12"
          md="12"
        >
          <v-text-field
            v-model="password"
            :counter="10"
            label="Password"
            hide-details
            required
          ></v-text-field>
        </v-col>
      </v-container>
    </v-form>
</template>
<script setup>
const valid = null
const email = ""
const password = ""
</script>
