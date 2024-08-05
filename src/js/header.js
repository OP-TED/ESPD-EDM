Vue.component("publicHeader", {
	data() {
		return {
			locales: ['eu', 'fr', 'ro'],
			show: true,
		}
	},
	methods: {
        doShow(component) {
			window.app.showLayout({ currentHeader: 'publicHeader', mainComponent: component, currentFooter: 'publicFooter' })
			console.log(`show ${component}`)
		},
		getLocale() {
			return this.$i18n.locale.toUpperCase()
		},
		localeFlagClass() {
			return `fi fi-${this.$i18n.locale}`
		},
		buildFlagClass(lang) {
			return `fi fi-${lang}`
		},
		changeLanguage(lang) {
			//save user language
			this.$i18n.locale = lang
			localStorage.setItem("language", this.$i18n.locale)
			this.localFlagClass = `fi fi-${lang}`
			console.log(lang)
		},
	},
	template: `
	<b-navbar toggleable="lg" type="light" variant="light">
			<b-navbar-brand href="https://docs.ted.europa.eu/espd-demo/">ESPD Demo</b-navbar-brand>
			<b-navbar-toggle target="nav-collapse"></b-navbar-toggle>
			<b-collapse id="nav-collapse" is-nav>

	<!-- Right aligned nav items -->
	<b-navbar-nav class="ml-auto">
	<!-- -->
	<b-nav-item href="#" @click="doShow('distribution')">{{$t("mainmenu.distribution")}}</b-nav-item>
	<b-nav-item href="#" @click="doShow('codelists')">{{$t("mainmenu.codelists")}}</b-nav-item>
	<!-- -->
	<b-nav-item href="#" @click="doShow('uuid')">{{$t("mainmenu.uuid")}}</b-nav-item>
    <!-- -->
	<b-nav-item href="#" @click="doShow('model')">{{$t("mainmenu.model")}}</b-nav-item>
    <b-nav-item href="#" @click="doShow('service')">{{$t("mainmenu.service")}}</b-nav-item>
    <!-- 
	<b-dropdown right size="lg"  variant="link" toggle-class="text-decoration-none" no-caret>
			<template #button-content>
				<span :class="localeFlagClass()"></span>&nbsp;{{ getLocale() }}&nbsp;<b-icon icon="translate" aria-hidden="true"></b-icon>
			</template>

			<b-dropdown-item v-for="item in locales" v-bind:key="item.id"
					 @click="changeLanguage(item)"><span :class="buildFlagClass(item)"></span>&nbsp; {{item.toUpperCase()}}</b-dropdown-item>
	</b-dropdown>
    -->
	</b-navbar-nav>
			</b-collapse>
	</b-navbar>
	`
});