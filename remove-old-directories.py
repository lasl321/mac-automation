import datetime
import os
import shutil
import argparse


def get_child_directories(parent_dir):
    return os.listdir(parent_dir)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Remove old directories.')
    parser.add_argument('--parent-directory', help='the path to the parent directory')
    parser.add_argument('--limit', help='the maximum number of directories to keep')

    args = parser.parse_args()

    parent_dir = args.parent_directory
    year = datetime.date.today().year
    limit = int(args.limit)

    print('Removing directories from \'{}\', limit: {}'.format(parent_dir, limit))

    child_directories = os.listdir(parent_dir)
    filtered_directories = filter(lambda d: d.startswith(str(year)), child_directories)
    sorted_directories = reversed(sorted(filtered_directories))
    full_paths = [os.path.join(parent_dir, sorted_directory) for sorted_directory in sorted_directories]
    old_paths = full_paths[limit:]

    for old_path in old_paths:
        print('deleting {}'.format(old_path))
        shutil.rmtree(old_path)
