module.exports = function(config) {
    config.set({
        basePath: '..',
        frameworks: ['dart-unittest'],

        // list of files / patterns to load in the browser
        files: [
            { pattern: '**/*.dart', watched: false, included: false, served: true },
            { pattern: 'packages/browser/dart.js', watched: false, included: true, served: true },
        ],

        autoWatch: true,

        plugins: [
            'karma-dart',
            'karma-chrome-launcher'
        ]
    });
};