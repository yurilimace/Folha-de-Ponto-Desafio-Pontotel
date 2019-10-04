<template>
  <div class="col-xl-6 offset-3 container margin">
    <div class="title">
      <h2>Espelho de Ponto</h2>
    </div>
    <div>
      <input colspan="6" v-model="search" placeholder="Digite um nome" />
      <br />
      <br />
    </div>
    <div>
      <template v-if="search == '' ">
        <table class="table table-bordered align-self-center">
          <thead>
            <tr>
              <th
                class="bg-success table-dark align-middle"
                v-for="(titulo,index) in colunas"
                :key="titulo.id"
              >
                {{titulo}}
                <button class="btn btn-success" disabled v-if="index == 1">
                  <span aria-hidden="true" v-if="button" @click="Asc">
                    <font-awesome-icon icon="arrow-down" />
                  </span>
                  <span v-else @click="Dsc">
                    <font-awesome-icon icon="arrow-up" />
                  </span>
                </button>
                <button class="btn btn-success" disabled v-if="index == 0">
                  <span aria-hidden="true" v-if="daybutton" @click="AscDia">
                    <font-awesome-icon icon="arrow-down" />
                  </span>
                  <span v-else @click="DscDia">
                    <font-awesome-icon icon="arrow-up" />
                  </span>
                </button>
              </th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="empregado in emp" :key="empregado.id">
              <td class="align-middle">{{Dataformat(empregado.dia)}}</td>
              <td class="align-middle">{{empregado.emp.name}}</td>
              <td
                class="align-middle"
                v-for="hora in empregado.pontos"
                :key="hora.id"
              >{{Hourformat(hora.time)}}</td>
            </tr>
          </tbody>
        </table>
      </template>

      <template v-else>
        <table class="table table-bordered align-self-center">
          <thead>
            <tr>
              <th
                class="bg-success table-dark align-middle"
                v-for="(titulo,index) in colunas"
                :key="titulo.id"
              >
                {{titulo}}
                <button class="btn btn-success" disabled v-if="index === 1">
                  <span aria-hidden="true" v-if="button" @click="Asc">
                    <font-awesome-icon icon="arrow-down" />
                  </span>
                  <span v-else @click="Dsc">
                    <font-awesome-icon icon="arrow-up" />
                  </span>
                </button>
                <button class="btn btn-success" disabled v-if="index === 0">
                  <span aria-hidden="true" v-if="daybutton" @click="AscDia">
                    <font-awesome-icon icon="arrow-down" />
                  </span>
                  <span v-else @click="DscDia">
                    <font-awesome-icon icon="arrow-up" />
                  </span>
                </button>
              </th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="empregado in Filtro" :key="empregado.id">
              <td class="align-middle">{{Dataformat(empregado.dia)}}</td>
              <td class="align-middle">{{empregado.emp.name}}</td>
              <td
                class="align-middle"
                v-for="hora in empregado.pontos"
                :key="hora.id"
              >{{Hourformat(hora.time)}}</td>
            </tr>
          </tbody>
        </table>
      </template>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import moment from "moment";

moment.locale("pt-br");
export default {
  name: "home",
  props: {
    msg: String
  },
  data() {
    return {
      daybutton: true,
      button: true,
      search: "",
      emp: [],
      colunas: [
        "Dia",
        "Funcionário",
        "Entrada",
        "Inicio da Pausa",
        "Retorno da Pausa",
        "Saida"
      ]
    };
  },

  mounted() {
    axios
      .get("https://s3-sa-east-1.amazonaws.com/lar21css/desafio_frontend.json")
      .then(response => {
        this.emp = this.listFormat(response.data.employees, response.data.days);
      });
  },

  computed: {
    Filtro() {
      if (!isNaN(this.search) || this.search.includes("/")) {
        const x = this.emp.filter(emp =>
          this.Dataformat(emp.dia)
            .toLowerCase()
            .includes(this.search.toLowerCase())
        );
        return x;
      } else {
        const x = this.emp.filter(emp =>
          emp.emp.name.toLowerCase().includes(this.search.toLowerCase())
        );
        return x;
      }
    }
  },

  methods: {
    Dataformat(data) {
      return moment.utc(data).format("DD/MM/YYYY - dddd");
    },
    Hourformat(data) {
      if (data.includes("s")) {
        return data;
      } else {
        return moment.utc(data).format("LT");
      }
    },
    listFormat(lista, lista2) {
      let newList = [];
      const complete = [
        { time: "sem registro de ponto", kind: "entrada" },
        { time: "sem registro de ponto", kind: "inicio da pausa" },
        { time: "sem registro de ponto", kind: "retorno da pausa" },
        { time: "sem registro de ponto", kind: "saida" }
      ];
      for (let i = 0; i < lista.length; i++) {
        for (let j = 0; j < lista2.length; j++) {
          if (lista[i].id == lista2[j].employee) {
            newList.push({
              emp: lista[i],
              dia: lista2[j].day,
              pontos: lista2[j].pontos
            });
            if (newList[i].pontos.length < 4) {
              for (let k = newList[i].pontos.length; k < 4; k++) {
                newList[i].pontos[k] = complete[k];
              }
            }
          }
        }
      }
      return newList;
    },

    Asc() {
      this.emp.sort(function(a, b) {
        if (a.emp.name > b.emp.name) {
          return 1;
        }
        if (a.emp.name < b.emp.name) {
          return -1;
        }
        return 0;
      });
      this.button = false;
    },

    Dsc() {
      this.button = true;
      this.emp.sort(function(a, b) {
        if (a.emp.name > b.emp.name) {
          return -1;
        }
        if (a.emp.name < b.emp.name) {
          return 1;
        }
        return 0;
      });
    },

    AscDia() {
      this.emp.sort(function(a, b) {
        if (a.dia > b.dia) {
          return 1;
        }
        if (a.dia < b.dia) {
          return -1;
        }
        return 0;
      });
      this.daybutton = false;
    },

    DscDia() {
      this.daybutton = true;
      this.emp.sort(function(a, b) {
        if (a.dia > b.dia) {
          return -1;
        }
        if (a.dia < b.dia) {
          return 1;
        }
        return 0;
      });
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
body {
  font-family: Helvetica Neue, Arial, sans-serif;
  font-size: 14px;
  color: #444;
}
.title{
  margin-bottom: 2em;
}
table {
  background-color: #fff;
}

th,
td {
  min-width: 120px;
  padding: 10px 20px;
}

.margin {
  margin-right: 700px;
  margin-bottom: 10px;
}

.btn:hover {
  cursor: pointer;
}
</style>
