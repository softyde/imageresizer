import { WebPlugin } from '@capacitor/core';
import { ImageResizerPlugin } from './definitions';

export class ImageResizerWeb extends WebPlugin implements ImageResizerPlugin {
  constructor() {
    super({
      name: 'ImageResizer',
      platforms: ['web']
    });
  }

  async echo(options: { value: string }): Promise<{value: string}> {
    console.log('ECHO', options);
    return options;
  }
}

const ImageResizer = new ImageResizerWeb();

export { ImageResizer };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(ImageResizer);
