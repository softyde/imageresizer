declare module "@capacitor/core" {
  interface PluginRegistry {
    ImageResizer: ImageResizerPlugin;
  }
}

export interface ImageResizerPlugin {
  echo(options: { value: string }): Promise<{value: string}>;
}
