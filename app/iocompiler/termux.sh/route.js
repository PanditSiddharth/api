import path from 'path';
import { promises as fs } from 'fs';

export async function GET(request) {
  const filePath = path.join(process.cwd(), 'public', 'install.sh');
  const fileContents = await fs.readFile(filePath, 'utf8');

  return new Response(fileContents, {
    headers: {
      'Content-Type': 'application/x-sh',
    },
  });
}
