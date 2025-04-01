<template>
  <div class="container">
    <h1>Busca de Operadoras</h1>
    <input
      v-model="searchQuery"
      placeholder="Digite o nome da operadora..."
      @input="fetchResults"
        />
    <ul v-if="results.length">
      <li v-for="operadora in results" :key="operadora.id">
      <strong>{{ operadora.nome_fantasia }}</strong> - {{ operadora.uf }}
    </li>
  </ul>
  <p v-else>Nenhuma operadora encontrada.</p>
</div>
</template >

<script>
import axios from "axios";

export default {
  data() {
    return {
      searchQuery: "",
      results: [],
    };
  },
  methods: {
    async fetchResults() {
      if (this.searchQuery.length > 2) {
        try {
          const response = await axios.get(
            'http://localhost:3000/api/search?query=${this.searchQuery}'
          );
          this.results = response.data;
        } catch (error) {
          console.error("Erro ao buscar operadoras:", error);
        }
      } else {
        this.results = [];
      }
    },
  },
};
</script>

<style>
.container {
  max-width: 600px;
  margin: auto;
  text-align: center;
}
input {
  width: 100%;
  padding: 10px;
  margin-bottom: 10px;
}
ul {
  list-style: none;
  padding: 0;
}
li {
  padding: 5px;
  border-bottom: 1px solid #ccc;
}
</style>