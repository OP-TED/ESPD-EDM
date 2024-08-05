Vue.component("home",{
    data: function(){
        return {
            show: true
        }
    },

    template: `
    <b-container fluid class="m-auto">
        <b-jumbotron bg-variant="info" text-variant="white" border-variant="dark">
            <template #header>ESPD Demo Site</template>

            <template #lead>
            This site is a collection of Tools allowing you to get familiar with ESPD model
    and examples. This site is provided for educational and training purpouses. It does not constitute an
    official implementation of the ESPD service. Consider this site as a Test or Playground to get familiar with ESPD.</p>
    <p>Feel free to download or copy-and-paste any parts of this example.
            </template>

            <hr class="my-4">

            <p>
            Your ESPD journey starts here! We would like to guide and assist you.
            </p>

        </b-jumbotron>
    </b-container>
    `
});