// Writes the markdown twin of each doc page next to it in the build (/page.md) for AI agents, and
// links it from the page with <link rel="alternate" type="text/markdown">. The home page links to
// llms.txt instead. Routes follow the docs plugin here: routeBasePath '/' and absolute slugs.
const fs = require('fs/promises');
const path = require('path');

const FRONT_MATTER = /^---\n([\s\S]*?)\n---\n+/;

async function markdownFiles(dir) {
  const entries = await fs.readdir(dir, { withFileTypes: true });
  const files = await Promise.all(
    entries.map((entry) => {
      const file = path.join(dir, entry.name);
      if (entry.isDirectory()) return markdownFiles(file);
      return /\.mdx?$/.test(entry.name) ? [file] : [];
    }),
  );
  return files.flat();
}

function routeOf(docsDir, file, source) {
  const frontMatter = source.match(FRONT_MATTER)?.[1] ?? '';
  const slug = frontMatter.match(/^slug:\s*['"]?([^'"\n]+)['"]?\s*$/m)?.[1];
  const relative = path
    .relative(docsDir, file)
    .split(path.sep)
    .join('/')
    .replace(/\.mdx?$/, '');
  if (slug?.startsWith('/')) return slug;
  return slug ? `/${path.posix.dirname(relative)}/${slug}` : `/${relative}`;
}

async function addAlternateLink(htmlFile, href) {
  const html = await fs.readFile(htmlFile, 'utf8').catch(() => null);
  if (!html) return;
  const link = `<link rel="alternate" type="text/markdown" href="${href}">`;
  await fs.writeFile(htmlFile, html.replace('</head>', `${link}</head>`));
}

module.exports = function markdownTwins(context) {
  return {
    name: 'markdown-twins',
    async postBuild({ outDir }) {
      const docsDir = path.join(context.siteDir, 'docs');
      const siteUrl = context.siteConfig.url.replace(/\/$/, '');
      for (const file of await markdownFiles(docsDir)) {
        const source = await fs.readFile(file, 'utf8');
        const route = routeOf(docsDir, file, source);
        const twin = route === '/' ? 'index.md' : `${route.slice(1)}.md`;
        await fs.mkdir(path.dirname(path.join(outDir, twin)), {
          recursive: true,
        });
        await fs.writeFile(
          path.join(outDir, twin),
          source.replace(FRONT_MATTER, ''),
        );
        const href =
          route === '/' ? `${siteUrl}/llms.txt` : `${siteUrl}/${twin}`;
        await addAlternateLink(
          path.join(outDir, route.slice(1), 'index.html'),
          href,
        );
      }
    },
  };
};
