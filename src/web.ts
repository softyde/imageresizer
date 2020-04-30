import { WebPlugin } from '@capacitor/core';
import { ImageResizerPlugin, ImageResizeOptions } from './definitions';

export class ImageResizerWeb extends WebPlugin implements ImageResizerPlugin {

  async resizeImage(_options: ImageResizeOptions): Promise<{ path: string; }> {
    throw new Error("Method not implemented.");
  }

  constructor() {
    super({
      name: 'ImageResizer',
      platforms: ['web']
    });
  }


}

const ImageResizer = new ImageResizerWeb();

export { ImageResizer };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(ImageResizer);
