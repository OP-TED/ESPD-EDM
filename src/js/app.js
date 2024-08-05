// 1. Create a vue root instance
window.app = new Vue({
	i18n,
	el: '#app',
	data: {
		currentHeader: 'publicHeader',
		currentFooter: 'publicFooter',
		mainComponent: 'home',
		locales: ['eu', 'fr', 'ro'],
	},

	methods: {
		showLayout(layout = { currentHeader: 'publicHeader', mainComponent: 'home', currentFooter: 'publicFooter' }) {
			this.mainComponent = layout.mainComponent
			this.currentHeader = layout.currentHeader
			this.currentFooter = layout.currentFooter
		},
	}

})


